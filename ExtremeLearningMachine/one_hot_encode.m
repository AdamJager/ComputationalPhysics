function [encodedLables] = one_hot_encode(features, lables)
    lablesSize = size(lables, 1);
    featuresSize = length(features);
    encodedLables = zeros(size(lables, 1), length(features));

    for lableIndex = 1:lablesSize
        for featureIndex = 1:featuresSize
            if features(featureIndex) == lables(lableIndex)
                encodedLables(lableIndex, featureIndex) = 1;
            end
        end
    end
    
end