
%     ^ Y
%     |
%     |
%     A
%     |- 
%     | ----
%     |     -----
%     |          ---
%     |             ---
%     |                ---
%     |                   -----B
%     |                        |
%     |                        | 
%     0 -----------------------C-----------------> X

classdef bh_quadshape_CLS
    properties
        x_col;
        y_col;
        z_thick
        mass 
    end

    properties(SetAccess = protected)
       P; % a polyshape
    end

    properties(Dependent = true)
        xy_cent_rel2_11
        volume
        density
        area
        P0
        PA
        PB
        PC
        PG
    end
%**************************************************************************
    methods
        function OBJ = bh_quadshape_CLS(x_list, y_list)
            arguments
                                                          %  0  C    B     A
                x_list (:,1) double {mustBeNonnegative}   = [0, 0.2, 0.2,  0]';
                y_list (:,1) double {mustBeNonnegative}   = [0, 0,   0.05, 0.2]';
%                 x_list (:,1) double {mustBeNonnegative}   = [0, 0.2, 0.2, 0]';
%                 y_list (:,1) double {mustBeNonnegative}   = [0,0,0.2,0.2]';
            end
   
            OBJ.x_col  = x_list;
            OBJ.y_col  = y_list;

            mat   = OBJ.get_xy();
            OBJ.P = polyshape(mat);
        end
        %------------------------------------------------------------------
        function mat = get_xy(obj)
                 mat = [obj.x_col, obj.y_col];            
        end
        %------------------------------------------------------------------
        function plot(obj)
            mat = get_xy(obj);
            figure;
            %plot(mat(:,1), mat(:,2), '-ro');
            
            % why not use the POLYSHAPE() function
            obj.P.plot();
            
            grid('on')
            hold on
            plot(mat(:,1), mat(:,2), 'k.');
            
            Xc = obj.xy_cent_rel2_11(1);
            Yc = obj.xy_cent_rel2_11(2);
            
            plot(Xc,Yc,'ro', "MarkerFaceColor", 'red',"MarkerEdgeColor", "k");
            
            axis('equal');
        end
        %------------------------------------------------------------------
        function value = get.xy_cent_rel2_11(obj)
            [Xc, Yc] = obj.P.centroid();
            value    = [Xc, Yc];
        end
        %------------------------------------------------------------------
        function value = get.area(obj)
            value = obj.P.area();
        end
        %------------------------------------------------------------------
        function value = get.volume(obj)
            value = obj.z_thick * obj.area;
        end
        %------------------------------------------------------------------
        function value = get.density(obj)
            value = obj.mass / obj.volume;
        end
        %------------------------------------------------------------------
        function value = get.P0(obj)
            value = [obj.x_col(1),  obj.y_col(1)];
        end
        %------------------------------------------------------------------
        function value = get.PC(obj)
            value = [obj.x_col(2),  obj.y_col(2)];
        end
        %------------------------------------------------------------------
        function value = get.PB(obj)
            value = [obj.x_col(3),  obj.y_col(3)];
        end
        %------------------------------------------------------------------
        function value = get.PA(obj)
            value = [obj.x_col(4),  obj.y_col(4)];
        end
        %------------------------------------------------------------------
        function value = get.PG(obj)
            [Xc, Yc] = obj.P.centroid();
            value    = [Xc, Yc];
        end
        %------------------------------------------------------------------
    end
end

