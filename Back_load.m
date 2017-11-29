function [connected_lines] = Back_load(adap)
% This funcito try to connect the dashed lines
    connected_lines = adap;
     for n = 2:size(connected_lines,1)-1
        for m = 2:size(connected_lines,2)-1
            if (adap(n,m)==0)
                if (adap(n-1,m-1)>0)          
                   connected_lines(n,m)=adap(n-1,m-1);
                elseif (adap(n-1,m)>0)
                    connected_lines(n,m)=adap(n-1,m);
                elseif (adap(n-1,m+1)>0)
                    connected_lines(n,m)=adap(n-1,m+1);
                elseif (adap(n,m+1)>0)
                    connected_lines(n,m)=adap(n,m+1);
                elseif (adap(n+1,m-1)>0)
                    connected_lines(n,m)=adap(n+1,m-1);
                elseif (adap(n+1,m)>0)
                    connected_lines(n,m)=adap(n+1,m);
                elseif (adap(n+1,m+1)>0)
                    connected_lines(n,m)=adap(n+1,m+1);
                end
            else
                connected_lines(n,m)=connected_lines(n,m);
            end
        end
     end

end