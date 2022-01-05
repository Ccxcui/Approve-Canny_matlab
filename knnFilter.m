function [ J ] = knnFilter( I )
%   边界保持类滤波器的K近邻中值滤波器
[l,w]=size(I);
M=5;K=9;                    %设定M*M为模板，K个邻近值
MM=M*M;                     %25
weighMM=ceil(M/2);          %3
lweighMM=fix(M/2);          %2
lhalfMM=fix(M*M/2);         %12
uhalfMM=ceil(M*M/2);        %13，为中心位置编号
iend=l-weighMM;
jend=w-weighMM;
J=I;
for i=weighMM:iend
    for j=weighMM:jend
        I1=I(i-weighMM+1:i+weighMM-1,j-weighMM+1:j+weighMM-1);%取出M*M的矩阵
        A=reshape(I1,1,MM);          %降为一维数组
        intA=int16(A);              %变成有符号数用来求绝对值大小
        for k=1:MM                  %将每个数与该矩阵中间数相减
            B(1,k)=int16(intA(uhalfMM)-intA(k));
        end
        BB=abs(B);                  %求绝对值，排序后绝对值最小的数为最接近的数
        [BBB,id]=sort(BB);              %id为排序前位置编号
        for k=1:K                  %将绝对值最小的K个数拿出
            C(1,k)=A(id(k));
        end
        J(i,j)=round(median(C));         %求这K个数的中值
    end
end
end
