function Experiment1(n,times)

accuracy = [];
domain = [-2^2:2^2];
domain_len = length(domain(:));
O = zeros(n/2,n/2);
I = eye(n/2);

for t=1:times
    sw = (rand(n/2,n/2)-0.5)*8;
    result = [sw O;O I];
    Y = [1:n-1];
    ai = n;
    P_index = [];
    flag = true;
    for i=1:n
        bi = i;
        pi = domain(ceil(rand*domain_len));
        p_cell(i) = pi;
        if (ismember(bi,Y))
            Y = Y(~ismember(Y,bi));
            deleFlag = true;
        end
        if (i>1)
            ai = Y(ceil(rand*length(Y(:))));
        end
        Y = Y(~ismember(Y,ai));
        if (deleFlag == true)
            Y(length(Y(:))+1) = bi;
            deleFlag = false;
        end
        P_index(i) = ai;
    end
    for i=1:n
        result(n-i+1,:) = result(n-i+1,:) + result(P_index(n-i+1),:)*p_cell(n-i+1);
        result(:,P_index(n-i+1)) = result(:,P_index(n-i+1)) + result(:,n-i+1)*-p_cell(n-i+1);
    end
    test_target = P_index(n/2+1:end);
    for i = 1 : n/2
        if (test_target(i) > n/2)
            test_row = result(:,test_target(i));
            target_row = zeros(n,1);
            target_row(test_target(i),1) = 1;
            if (target_row ~= test_row)
                flag = false;
            end
        end    
    end
    disp(P_index);
    disp(result);
    if (flag)
        accuracy = [accuracy 1];
    end
end

disp('accuracy:')
disp(sum(accuracy)/times);
end

