%Function to create the model with 8 or 15 parents
function model=modelCreator(X,ind,numberofParents)
	%X is a dxdxt array

	n=size(X,3);
	
	subM=subMatrix(X,ind,numberofParents);
	M=max(size(subM,1),size(subM,2));
	m=min(size(subM,1),size(subM,2));
	aux=M*m; %Size of each submatrix
	
	allData=subM(:);
	allData=reshape(allData,n,aux);
	%splitting parents and kid	
	model.child=allData(:,aux); %Value of the pixel
	model.parents=allData(:,1:(end-1)); %value of the parents.

	tempModel=binaryTabular(model.parents,model.child,1);
	model.parents=tempModel.rows(:,1:(end-1)); %realization of parents
	model.childs=tempModel.rows(:,end);
	model.sample=@sample;
	model.tempModel=tempModel;
	model.subMatrix=@subMatrix;
	
	


end	
		
		
function ysample=sample(model,xhat)
	s=model.tempModel;
	ysample=s.sample(s,xhat);
end	




function subM=subMatrix(X,ind,numberofParents)
	%X is the array with all the images size dxdxt
	%ind are the index [i j] where we want to create the model of
	%numberofParents can be 8 or 15
	
	d=size(X,1);
	x=0;y=0;	
	if numberofParents==8
	%evaluate cases
		if (ind(1)-2)<=0
			if(ind(1)-1<=0)
				x=ind(1);
			else
				x=ind(1)-1;
			end
		else
			x=ind(1)-2;
		end

		if (ind(2)-2)<=0
			if(ind(2)-1<=0)
				y=ind(2);
			else
				y=ind(2)-1;
			end
		else 	
			y=ind(2)-2;
		end	
		subM=X(x:ind(1),y:ind(2),:);

	%%%%%%%%%%%%%%Number of parents 15 %%%%%%%%%%%%%%%%%%%%	
	elseif numberofParents==15
		if (ind(1)-3)<=0
			if(ind(1)-2<=0)
				if(ind(1)-1<=0)
					x=ind(1);
				else
					x=ind(1)-1;
				end
			else
				x=ind(1)-2;
			end
		else
			x=ind(1)-3;
		end

		if (ind(2)-3)<=0
			if(ind(2)-2<=0)
				if(ind(2)-1<=0)
					y=ind(2);
				else
					y=ind(2)-1;
				end
			else
				y=ind(2)-2;
			end
		else
			y=ind(2)-3;
		end
		subM=X(x:ind(1),y:ind(2),:);
	else
		error('numberofParents has to be 8 or 15')
	end

	
	
end
