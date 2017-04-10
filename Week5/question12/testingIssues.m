%Script to test issues
addpath(genpath('UGM'))
example_UGM

potVals=reshape(exp(w(1:36)),4,9);
potVals=[potVals ones(4,1)];

binaryPotVals=zeros(10,10,6); %Where we store all the binary potentialsa
binaryPotVals(:,:,1)=reshape(exp(w(37:136)),10,10); %phi_12
binaryPotVals(:,:,2)=reshape(exp(w(137:236)),10,10); %phi_13
binaryPotVals(:,:,3)=reshape(exp(w(237:336)),10,10); %phi_14
binaryPotVals(:,:,4)=reshape(exp(w(337:436)),10,10); %phi_23
binaryPotVals(:,:,5)=reshape(exp(w(437:536)),10,10); %phi_24
binaryPotVals(:,:,6)=reshape(exp(w(537:636)),10,10); %phi_34





display('the decoding is: ')
xDecode

display('the marginal prob for 1 is: ')
%Memoizing the potentials
M3=(binaryPotVals(1,:,3).*potVals(4,:))*binaryPotVals(:,:,6);
M2=(M3.*potVals(3,:).*binaryPotVals(1,:,2))*binaryPotVals(:,:,4);
M=(M2.*potVals(2,:))*binaryPotVals(1,:,1)';
potVals(1,1)*M/Z

%M=binaryPotVals(:,:,3)*potVals(4,:)';
%M=binaryPotVals(:,:,2)*(M.*potVals(3,:)');
%M=binaryPotVals(:,:,1)*(M.*potVals(2,:)');
%potVals(1,1)*M(1)/Z



display('the marginal prob for 1 in the second slot is: ')



%M=binaryPotVals(:,:,3)*potVals(4,:)';
%aux=M.*potVals(3,:)'.*binaryPotVals(1,:,2)';
%M=sum(aux)*(potVals(1,:)*(binaryPotVals(:,1,1)));
%potVals(2,1)*M/Z




display('the marginal prob for 1 in the third slot is: ')

M1=binaryPotVals(1,:,3)*potVals(4,:)';
M=binaryPotVals(:,:,1)*potVals(1,:)';
aux=(potVals(2,:).*M')*binaryPotVals(:,1,2)*M1;
potVals(3,1)*aux/Z


display('the marginal prob for 1 in the fourth slot is: ')

M=binaryPotVals(:,:,1)*potVals(1,:)';
aux=binaryPotVals(1,:,2)*(M.*potVals(2,:)');
M=binaryPotVals(1,:,3)*(aux.*potVals(3,:)');
potVals(4,1)*M/Z

display('The prob of a four in the end is: ')
condNM(4)
