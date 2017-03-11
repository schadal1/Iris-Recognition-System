%function to find the center and radius of the circle detected by hough
%transform and canny edge detection
function [row, col, r] = findcircle(image,lradius,uradius,scaling, sigma, hithres, lowthres, vert, horz)
lradsc = round(lradius*scaling);
uradsc = round(uradius*scaling);
rd = round(uradius*scaling - lradius*scaling);


[I2 or] = canny(image, sigma, scaling, vert, horz);% canny edge detection is done by this function.canny is more efficient                                              
figure,imshow(uint8(I2));%canny will always return double value so it is converted to uint to display
title('Canny Edge Detection Image');
I3 = adjgamma(I2, 1.9); %It will increase the contrast of the edge detected output
figure,imshow(I3,[]);
title('Contrast Enhanced Edges');

edgeimage = hysthresh(I3, hithres, lowthres); %Binary Conversion
figure,imshow(edgeimage);
title('Binary Image');

% perform the circular Hough transform
h = houghcircle(edgeimage, lradsc, uradsc);

maxtotal = 0;

% find the maximum in the Hough space, and hence
% the parameters of the circle
for i=1:rd
    
    layer = h(:,:,i);
    [maxlayer] = max(max(layer));
    
    
    if maxlayer > maxtotal
        
        maxtotal = maxlayer;
        
        
        r = int32((lradsc+i) / scaling);
        
        [row,col] = ( find(layer == maxlayer) );
        
        
        row = int32(row(1) / scaling); % returns only first max value
        col = int32(col(1) / scaling);    
        
    end   
    
end

z=h(:,:,end);
figure,imshow(z,[]);
title('Hough Circle');