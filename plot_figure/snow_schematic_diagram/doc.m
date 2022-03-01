%% Koch_snowflake_3D
%
% Function to compute, display, and save a 3D Koch snowflake
% at any iteration / depth level.
%
% Author & support : nicolas.douillet (at) free.fr, 2019-2020.
%
%% Syntax
%
% Koch_snowflake_3D;
%
% Koch_snowflake_3D(nb_it);
%
% Koch_snowflake_3D(nb_it, printable_ready);
%
% Koch_snowflake_3D(nb_it, printable_ready, display_option);
%
% [V, T] = Koch_snowflake_3D(nb_it, printable_ready, display_option);
%
%% Description
%
% Koch_snowflake_3D computes and displays the 3-
% 3D_Koch snowflake included in the unit sphere.
% 
% Koch_snowflake_3D(nb_it) computes and displays the nb_it
% 3D_Koch snowflake included in the unit sphere.
%
% Koch_snowflake_3D(nb_it, printable_ready) prevents from
% creating non manifold edges when printable_ready is set to *true /
% logical 1, and remove duplicated vertices and faces when it is set to
% false / logical 0. In this latter case, the model is lighter (less
% vertices, less faces), but at the cost of non manifoldness.
%
% Koch_snowflake_3D(nb_it, printable_ready, option_display) displays it when
% option_display is set to logical *true/1 (default), and doesn't
% when it is set to  logical false/0.
%
% [V, T] = Koch_snowflake_3D(nb_it, printable_ready, option_display) saves the resulting
% vertex coordinates in the array V, and the triangulation in the array T.
%
%% See also
%
% <https://fr.mathworks.com/matlabcentral/fileexchange/73216-cubic-based-3d-koch-snowflake cubic_based_3D_Koch_snowflake>
%
%% Input arguments
%
% - nb_it : positive integer scalar double, the number of iterations / depth level.
%
% - printable_ready : either logical, true/*false or numeric 1*/0.
%
% - option_display : either logical, *true/false or numeric *1/0.
%
%% Output arguments
%
%        [ |  |  |]
% - V = [Vx Vy Vz], real matrix double, the vertex coordinates. Size(V) = [nb_vertices,3].
%        [ |  |  |]
%
%        [ |  |  |]
% - T = [T1 T2 T3], positive integer matrix double, the triangulation. Size(T) = [nb_triangles,3].
%        [ |  |  |]
%
%% Example #1
% Compute and display the 3D Koch snowflake at iteration 1, with minimum
% vertex and face numbers

Koch_snowflake_3D(1);

%% Example #2
% Compute and save the 3D Koch snowflake at iteration 2, 3D printable ready, no display

[V,T] = Koch_snowflake_3D(2,true,false);