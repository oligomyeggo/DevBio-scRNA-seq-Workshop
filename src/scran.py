# Code and descriptive text written by Malte Luecken as part of Luecken and Theis, 2019
# see https://github.com/theislab/single-cell-tutorial for more information

import scanpy as sc
import seaborn as sb
import scipy as sp
import matplotlib.pyplot as plt
import rpy2.robjects as ro
import anndata2ri

from typing import Optional, Sequence
from anndata import AnnData

def scran(
    adata: AnnData,
    verbose: bool = True,
    seed: int = 0
) -> Optional[AnnData]:
    """\
    Normalization and variance stabilization of scRNA-seq data using scran (Lun et al., 2016).

    Because we cannot assume that all cells contain an equal number of molecules (cell sizes can
    differ substantially), we have to estimate the number of molecules that were initially in
    the cells by estimating cell-specific factors that should be proportional to the true number
    of molecules. These are called size factors. Normalized expression values are calculated by 
    dividing the measured counts by the size factor for the cell. scran normalization requires a 
    coarse clustering input to improve size factor esimation performance. Thus, we use a simple
    preprocessing approach and cluster the data at a low resolution to get an input for the size 
    factor estimation. The basic preprocessing includes assuming all size factors are equal (library 
    size normalization to counts per million - CPM) and log-transforming the count data.

    This function assumes that basic Quality Control (via `sc.pp.calculate_qc_metrics` and
    `sc.pp.filter_cells`) has been completed. Extracting highly variable genes 
    (`sc.pp.highly_variable_genes`) would follow running this normalization script.

    Parameters
    ----------
    adata
        An anndata file
    verbose
        Show progress bar during normalization.
    seed
        Random seed for R RNG. Default is 0.
    
    Returns
    -------
    Anndata is returned.
    """

    ro.r('library(scran)')
    anndata2ri.activate()

    # Perform a clustering for scran normalization in clusters
    adata_pp = adata.copy()
    sc.pp.normalize_per_cell(adata_pp, counts_per_cell_after=1e6)
    sc.pp.log1p(adata_pp)
    sc.pp.pca(adata_pp, n_comps=15)
    sc.pp.neighbors(adata_pp)
    sc.tl.leiden(adata_pp, key_added='groups', resolution=0.5)

    # Preprocess variables for scran normalization
    input_groups = adata_pp.obs['groups']
    data_mat = adata.X.T

    ro.globalenv['input_groups'] = input_groups
    ro.globalenv['data_mat'] = data_mat

    size_factors = ro.r('sizeFactors(computeSumFactors(SingleCellExperiment(list(counts=data_mat)), clusters=input_groups, min.mean=0.1))')

    # Delete adata_pp
    del adata_pp

    # Visualize the estimated size factors
    # Size factors should be non-negative and related to the number of counts and genes per cell as expected
    adata.obs['size_factors'] = size_factors
    sc.pl.scatter(adata, 'size_factors', 'n_counts')
    sc.pl.scatter(adata, 'size_factors', 'n_genes')
    sb.distplot(size_factors, bins=50, kde=False)

    # Keep a copy of the raw count data in a counts layer
    # Always save a copy of the raw count data, as some downstream analysis methods require it!
    adata.layers["counts"] = adata.X.copy()

    # Normalize adata. This results in type(adata.X)=numpy.matrix. 
    adata.X /= adata.obs['size_factors'].values[:,None]
    sc.pp.log1p(adata)

    # Convert numpy.matrix to sp.sparse.csr.csr_matrix for downstream analysis.
    adata.X = sp.sparse.csr_matrix(adata.X)

    # Store the full data set in 'raw' as log-normalised data for statistical testing
    adata.raw = adata

    return adata