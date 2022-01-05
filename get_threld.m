% 最佳阈值法获取图像二值化的阈值
% T - 得到的最佳阈值
% I - 输入图像
% allow - 迭代过程中，当前迭代得到的阈值与下一轮迭代得到的阈值之差的绝对值小于allow，则认为找到了最佳阈值
 
 
function [T] = get_threld(I, allow)
 
 
[x,y] = size(I);                % 求出图象行列数
b = double(I);       %把图像由整型转换为浮点型           
                        
T_current = max(b(:))+min(b(:))/2;  %取图像的均值作为初始阈值T0
  
T_next = 0;                               %TT赋初值
S0 = 0.0;               %为计算灰度大于阈值的元素的灰度总值、个数赋值
n0 = 0.0;                       
S1 = 0.0;                  %为计算灰度小于阈值的元素的灰度总值、个数赋值
n1 = 0.0;                      
d = abs(T_current-T_next);
count = 0;
% 记录几次循环
while(d >= allow)                 % 迭代最佳阈值分割算法
    
    count = count+1;       %迭代次数加1
    
    for i = 1:x      %遍历每一行
        for j = 1:y  %遍历每一列
            
            if b(i,j) >= T_current   %计算图像中所有像素值大于阈值的点的像素值之和
                S0 = S0 + b(i,j);     
                n0 = n0 + 1;
            else             %计算图像中所有像素值小于阈值的点的像素值之和
                S1 = S1 + b(i,j);
                n1 = n1 + 1;
            end
 
 
        end
    end 
    
    T0 = S0/n0;   %计算图像中所有像素值大于阈值的点的像素值平均值
    T1 = S1/n1;   %计算图像中所有像素值小于阈值的点的像素值平均值
    
    %T_next = (T0+T1)/2;     %原迭代算法
    T_next = T1 + (T0-T1)*0.9;  %改进的迭代算法
    
    d = abs(T_current-T_next);    %当前迭代得到的阈值与下一轮迭代得到的阈值之差的绝对值
    T_current = T_next;         %把下一轮迭代的阈值赋值给当前轮迭代的阈值
end
 
 
mmax = max(max(I));
T = T_current/double(mmax);       %把求得的阈值处以图像的最大像素值进行归一化
 
 
end