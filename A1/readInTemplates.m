function [g_templates, gray_thermo, dimensions, corrArray,maxCorr, maxIdx, index_thershold, candX, candY, thisCorr] = readInTemplates

inputFolderRoot = 'DIGITS';
idx = 1 ;
img = imread('thermometer.png');
gray_thermo = double(rgb2gray(img));
[M, N] = size(gray_thermo);
corrArray = double(zeros(size(gray_thermo,1),size(gray_thermo,2),30));
for(s = 1 : 3 )
    inputFolder = fullfile( inputFolderRoot , ['SCALE_', num2str(s)]);
    
    
    for( i = 0 : 9 )
        templateFile = [ num2str(i), '.png'];
        
        templates{idx} = imread( fullfile( inputFolder , templateFile) );
        g_templates{idx} = double(rgb2gray(templates{idx}));
        dimensions(idx).height = size(templates{idx},1);
        dimensions(idx).width  = size(templates{idx},2);
        
        %%corrArray{idx} = normxcorr2(g_templates{idx},gray_thermo);
        
        
        
        pre_offSetX = round(dimensions(idx).width/2);
        pre_offSetY = round(dimensions(idx).height/2);
        
        offSetX = pre_offSetX + N - 1;
        offSetY = pre_offSetY + M - 1;
        
        A = normxcorr2(g_templates{idx},gray_thermo);
        corrArray(:,:,idx) = A(pre_offSetY:offSetY, pre_offSetX:offSetX);
        %%corrArray{idx} = corrArray{idx}(pre_offSetY:offSetY, pre_offSetX:offSetX);
        
        idx = idx + 1;
    end

end

[maxCorr, maxIdx] = max(corrArray,[],3);
index_thershold = find(maxCorr > 0.77);
[candY, candX] = ind2sub(size(maxCorr),index_thershold);


imshow('thermometer.png')
for( i = 1 : size(candX) )
    templateIndex = maxIdx(candY(i),candX(i));
    thisCorr = corrArray(:,:,templateIndex);
    if (isLocalMaximum(candY(i),candX(i),thisCorr))
        drawAndLabelBox(candX(i), candY(i), templateIndex, dimensions)
        drawnow
    end
end







