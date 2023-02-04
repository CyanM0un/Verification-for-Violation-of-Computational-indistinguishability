function Experiment2(n,times) % n acutally means "2n"

accuracy = [];
r = 10;
m = 10;
Q = [-2^r:2^r];
O = zeros(n/2,n/2);
I = eye(n/2);

for t = 1:times
    p = rand;
    if (p > 0.5)
        Sw = (rand(n/2,n/2)-0.5)*2^(r+m);
    else
        Sw = eye(n/2);
        Y = [1:n/2-1];
        ai = n/2;
        for i = 1:n/2
            bi = i;
            if (ismember(bi,Y))
                Y = Y(~ismember(Y,bi));
                deleFlag = true;
            end
            if (i > 1)
                ai = Y(ceil(rand*length(Y(:))));
            end
            Y = Y(~ismember(Y,ai));
            Sw(bi,ai) = (rand-0.5)*2^(m+n);
            if (deleFlag == true)
                Y(length(Y(:))+1) = bi;
                deleFlag = false;
            end
        end
    end
    result = [Sw O;O I];

    Y = [1:n-1];
    ai = n;
    P_index = [];
    flag = true;
    for i=1:n
        bi = i;
        pi = Q(ceil(rand * (length(Q(:)) - 2)) + 1);
        p_cell(i) = pi;
        if (ismember(bi,Y))
            Y = Y(~ismember(Y,bi));
            deleFlag = true;
        end
        if (i > 1)
            ai = Y(ceil(rand*length(Y(:))));
        end
        Y = Y(~ismember(Y,ai));
        if (deleFlag == true)
            Y(length(Y(:))+1) = bi;
            deleFlag = false;
        end
        P_index(i) = ai;
    end

    % disp(P_index);
    % disp(result);

    for i=1:n
        result(n-i+1,:) = result(n-i+1,:) + result(P_index(n-i+1),:)*p_cell(n-i+1);
        result(:,P_index(n-i+1)) = result(:,P_index(n-i+1)) + result(:,n-i+1)*-p_cell(n-i+1);
    end

    % disp(result);
    test_target = result(n/2+1:n,1:n/2);
    row_zero = zeros(1,n/2);
    flag = true;
    for i = 1:n/2
        temp = test_target(i,:);
        disp(temp);
        if (temp ~= row_zero)
            count = length(find(temp == 0));
            if (count <= 2)
                flag = false;
                break;
            end
        end
    end

    disp(flag);
    if((flag && p <= 0.5) || (~flag && p > 0.5))
        accuracy = [accuracy 1];
    end

end

disp('accuracy:')
disp(sum(accuracy)/times);

end

