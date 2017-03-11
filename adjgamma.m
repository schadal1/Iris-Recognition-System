% ADJGAMMA - Adjusts image gamma.
%if g<1, bright part is enhansed if g>1, dark part is enhansed

function newim = adjgamma(im, g)

    		newim = im;
    % rescale range 0-1
    newim = newim-min(min(newim));
    newim = newim./max(max(newim));
    
    newim =  newim.^(1/g);  %Normalization


