function Thr = MinimizationThresholding (Image) % import gray sclae image
[m,n] = size(Image); % size of the image
figure(1);
imshow(Image,[])
title('Original Image')
%% finding Image Histogram
Im_hist = imhist(Image);
total_pixels = m * n;  % N value from the lecture notes
%% finding probabilities of all histogram values
P = Im_hist/total_pixels;
Var_w = [];
for T = 1:255
    % Applying all lecture equations for histogram thresholding for all
    % intensities
    P_o = sum(P(1:T));
    P_b = sum(P(T+1:256));
    Mu_o = sum(dot((1:T),P(1:T))/P_o);
    Mu_b = sum(dot((T+1:256),P(T+1:256))/P_b);
    Var_o = sum((((1:T)- Mu_o).^2)*P(1:T)/P_o);
    Var_b = sum((((T+1:256)- Mu_b).^2)*P(T+1:256)/P_b);
    Var_w (T)= Var_o * P_o + Var_b * P_b;
end
min_var = min(Var_w); % minimum within group variance is extracted 
Thr = find(Var_w == min_var); % And the relating threshold is pushed
Thr = Thr(1,1);

figure(2);
imshow(Image>Thr(1,1))
title(['Binarized Image, Thr = ' ,num2str(Thr(1,1))])
end