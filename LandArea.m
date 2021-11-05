classdef LandArea < handle
    properties
        Name (1,1) string
        CumulativeCases (:, :) double
        CumulativeDeath (:, :) double
        DailyCases (1, :) double
        DailyDeath (1, :) double
        StateObjects (:, 1) LandArea
    end
    properties (Access=private)
        All_states (:, 1) string
    end
    methods
        function obj = LandArea(name, cases, death, all_states)
            arguments
                name = ""; cases = []; death = []; all_states = [];
            end
            obj.Name = name;
            obj.CumulativeCases = cases;
            obj.CumulativeDeath = death;
            obj.All_states = all_states;
            % finding the states and creating the state objects
            if ~isempty(obj.All_states)
                [states, positions] = hasStates(obj);
                createStateObjects(obj, states, positions);
            end
        end
        
        % function for returning all the states or all the count
        function statesnames = stateNames(obj)
            statesnames = "";
            if ~isempty(obj.StateObjects)     % if state is not empty get all the states
                for idx=1:length(obj.StateObjects)
                    statesnames(idx, 1) = obj.StateObjects(idx).Name;
                end
            else                        % else return nothing
                clear statesnames
                return;
            end
        end
        
        function name = get.Name(obj)
            name = char(obj.Name);
        end
    end
    
    methods (Access=private)
        % function for extracting all the states for a country
        function [states, positions] = hasStates(obj)
            positions = find(startsWith(obj.All_states, obj.Name+"/"));
            states = extractAfter(obj.All_states(positions), "/");
        end
        
        % function creating the objects of states for a country
        function createStateObjects(obj, states, positions)
            for idx=1:length(states)
                pos = (positions(idx));
                obj1 = LandArea(states(idx), ...
                    obj.CumulativeCases(pos, :), ...
                    obj.CumulativeDeath(pos, :));
                % computing the daily data
                computeDaily(obj1);
                obj.StateObjects = [obj.StateObjects; obj1];
            end
        end
        
        % function to compute daily cases
        function computeDaily(obj)
            [m, ~] = size(obj.CumulativeDeath);
            obj.DailyCases = max(obj.CumulativeCases - [zeros(m, 1) obj.CumulativeCases(:, 1:end-1)], 0);
            obj.DailyDeath = max(obj.CumulativeDeath - [zeros(m, 1) obj.CumulativeDeath(:, 1:end-1)], 0);
        end
    end
    
end