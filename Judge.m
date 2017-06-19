        function J=Judge(x0,x1,e)
            if e == 0;
                J = 0;
                return 
            end
            if abs(x1 - x0) < e;
                J = 1;
                return 
            else
                J = 0;
                return 
            end
        end
        

        