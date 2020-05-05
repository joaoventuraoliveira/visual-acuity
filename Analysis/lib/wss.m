function [avgData, wssAvg] = wss(data,name,avg)
    % Average replicate observations at discrete values
    avgData = averageData(data,(1+(strcmp(name,'Fully Crowded'))));

    if(strcmp(name,'Anstis'))
        avgData(:,3) = 0;
        wssAvg = 0.52;
        return;
    end
    
    xvals = avgData(:,1)';
    yvals = avgData(:,2)';
    
    variance = (avgData(:,3)').^2;
    
    %To avoid error caused by dividing by zero
    variance(variance == 0) = 0.000001;
    
    % Weights are assumed to be 1/standard error, normalized to 0-1
    w = 1./variance;
    w = w - min(w(:));
    w = w./max(w(:));
    
    % Weighted least sum of squares equation to be minimized
    f = @(x,xvals,yvals,w)sum(w.*((yvals-(xvals.*x)).^2));
        
    % fminbnd iteratively searches for the slope parameter which
    % minimizes the WLSS equation
    fun = @(x)f(x,xvals,yvals,w);
    xMin = avg*0.5;
    xMax = avg*1.5;
    options = optimset('Display','Iter');
    [wssAvg, fval] = fminbnd(fun,xMin,xMax, options);

    ss = sum((yvals-(xvals.*wssAvg)).^2);
    disp(sqrt(ss/length(xvals)));

    disp(sqrt(fval/length(xvals)));

    disp(sqrt(mean(w.*((yvals-(xvals.*wssAvg))).^2)));
end