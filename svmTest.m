function acc=svmTest(W,H,text_feature,data,train_ratio,C)
    load([data,'/group.txt']);
    numOfNode = size(group,1);
    if strcmp(data,'citeseer')
        numOfGroup = 6;
    elseif strcmp(data,'cora')
        numOfGroup = 7;
    else
        numOfGroup = 19;
    end

    group(:,1) = group(:,1) + 1;
    if strcmp(data,'wiki')==0
        group(:,2) = group(:,2) + 1;
    end
    group = sparse(group(:,1),group(:,2),ones(size(group(:,1))),numOfNode,numOfGroup);

    grouptmp=group;
    acc=0;
    features = [W' text_feature*H'];    % representation learned by TADW
    for i=1:size(features,2)
        if (norm(features(:,i))>0)
            features(:,i) = features(:,i)/norm(features(:,i));
        end
    end
    
    for i=1:10  % do the procedure for 10 times and take the average
        rp = randperm(numOfNode);
        testId = rp(1:floor(numOfNode*(1-train_ratio)));

        groupTest = group(testId,:);
        group(testId,:)=[];

        trainId = [1:numOfNode]';
        trainId(testId,:)=[];

        result=SocioDim(features, group, trainId, testId, C);
        [res b] = evaluate(result,groupTest);
        acc=acc+res.micro_F1;
        group=grouptmp;
    end
    acc=acc/10;