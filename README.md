# tracktools
Collection of scripts useful for tracks manipulation, HTML loading, 3D printing

Welcome to tracktools!
These are a files in Matlab and Javascript to do few useful things with your tractography. The current plan is a total porting on Python.

the html_visualizer uses a javascript developed by XTK to allow you to insert your tractography in your website:
[![Alt text](screenshot.png)](https://vimeo.com/422572632)

the TransTrk2Vtk.m file allows you to convert trk files into VTK.

UPCOMING: TRK to STL for 3D printing. Unfortunally, you canno just convert VTK files into STL for 3D printing or Augmented Reality as fiber bundles are not converted directly into surface.
[![Alt text](screenshot.png)](https://vimeo.com/385360489)

The TRK reader and writer were originally developed by John Colby, UCLA Developmental Cognitive Neuroimaging Group (Sowell Lab)
