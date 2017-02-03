function [TPR,FPR,Roc1] = ROCValue(TP1,all_CoAp, options)
for jj=1:options.itrnum
    TP =0;
    sumsample = 0;
    negative =0;
    positive = 0;
    FP = 0;
    for numtext=1: size(TP1{1},1)
        for iM=1: length(find(~cellfun(@isempty,all_CoAp(numtext,:))))
           
            if(TP1{jj}{numtext,iM}(2)==1 && TP1{jj}{numtext,iM}(1)==1)
            TP = TP+ 1;
            end
            if(TP1{jj}{numtext,iM}(2)==0 && TP1{jj}{numtext,iM}(1)==0)
                FP = FP +1;
            end
            
             if(TP1{jj}{numtext,iM}(2)==0)
                negative = negative +1;
            else
                positive = positive +1;
             end
             sumsample = sumsample +1;            
        end
    end
        
    TPR = TP/positive;
    FPR = FP/negative;
    if (negative==0)
       FPR =0;
    end
    Roc1(jj,1) = TPR ;
    Roc1(jj,2) = FPR ;

end
