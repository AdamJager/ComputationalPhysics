classdef testClass < handle

    properties
        testProperty1
        testProperty2
    end

    methods
        function obj = testClass()
            %UNTITLED3 Construct an instance of this class
          %   Detailed explanation goes here
            obj.testProperty1 = 0;
            obj.testProperty2 = 0;
        end

        function increment(obj, incrementFactor)
            %METHOD1 Summary of this method goes here
           %   Detailed explanation goes here
            obj.testProperty1 = obj.testProperty1 + incrementFactor;
        end

        function betterIncrement(obj, incrementFactor)
            obj.testProperty1 = obj.testProperty1 + incrementFactor;
            obj.testProperty2 = obj.testProperty2 + incrementFactor;

        end
    end
end   