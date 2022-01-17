# pixel-project

In this project, a randomply generated 64 by 64 grid was created and each pixel was assigned one of 8 colors (black=0, pink=1, red=2, green=3, blue=4, orange=5,
yellow=6, skyblue=7). The goal of the program was  to find a part that has a certain color (given as input) and report the part's bounding box, which is the upper
left corner pixel location and the lower right corner pixel location.Each part is composed of horizontal and vertical lines all of the same color. Not all parts have
the same number of horizontal or vertical lines. All horizontal lines in a part have the same length which ranges from 25 to 45 pixels. Similarly, all vertical lines 
in a part have the same length in the same range. A part’s horizontal line length is not necessarily the same as its vertical line length. No parallel lines are adjacent 
to any other lines in the same part or in other parts. Each row (column) has at most one horizontal (vertical) line. No horizontal lines occlude (overlap) any other 
horizontal lines (i.e., no part will overlap another part along the same horizontal line). Similarly, no vertical lines occlude any other vertical lines. If a row contains
a horizontal line, the row immediately above and the row immediately below that row will not contain any horizontal lines. Similarly, the columns immediately to the right 
and left of a column that contains a vertical line will not contain any vertical lines. There will be at most one line in any givenrow or column. Lines only touch at 
orthogonal intersections. There may be intersections among the parts and within the parts themselves that form a T (that is, intersections that do not have a
pixel hanging off the other side). No lines touch the image boundaries.

The C portion was created first to get a better undestanding of the algorithm and then the assembly.

