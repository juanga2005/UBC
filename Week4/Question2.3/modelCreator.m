%Function to create the model with 8 or 15 parents
function model=modelCreator(X,ind,numberofParents)
		%X is a dxdxt array
		%What is left to be done is to calculate probabilities for each 
		%pixel.	





function subM=subMatrix(X,ind,numberofParents)
	%X is the matrix with the image
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
		subseting=X(x:ind(1),y:ind(2));

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
		subseting=X(x:ind(1),y:ind(2));
	else
		error('numberofParents has to be 8 or 15')
	end

	
	
end
