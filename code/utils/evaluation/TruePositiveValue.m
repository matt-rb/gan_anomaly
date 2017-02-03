function TP1 = TruePositiveValue(result,all_CoAp,options)
for numtext=1:size(result{1},1)
    for iM=1:length(find(~cellfun(@isempty,all_CoAp(numtext,:))))
        for jj=1:options.itrnum
            
            if(result{jj}{numtext,iM}(2) == 0 &&result{jj}{numtext,iM}(1)<=options.th_roc)
                TP1{jj}{numtext,iM}(1) = 1;
                TP1{jj}{numtext,iM}(2) = 0;
            elseif(result{jj}{numtext,iM}(2) == 0 &&result{jj}{numtext,iM}(1)>options.th_roc)
                TP1{jj}{numtext,iM}(1) = 0;
                TP1{jj}{numtext,iM}(2) = 0;
            end
            if(result{jj}{numtext,iM}(2) == 1 &&result{jj}{numtext,iM}(1)>=options.threshold_pixellevel)
                TP1{jj}{numtext,iM}(1) = 1;
                TP1{jj}{numtext,iM}(2) = 1;
            elseif(result{jj}{numtext,iM}(2) == 1 &&result{jj}{numtext,iM}(1)<options.threshold_pixellevel)
                TP1{jj}{numtext,iM}(1) = 0;
                TP1{jj}{numtext,iM}(2) = 1;
            end
        end
    end
end