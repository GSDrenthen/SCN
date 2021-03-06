% Preprocessing morphological measure (e.g. cortical thickness)
% X_lin : matrix with variables to be regressed out (e.g. age and sex)
% y_lin : vector with morphology measure
function [corrected_morph] = preprocess_morph(X_lin,y_lin)
for n = 1:size(y_lin,2)
    linearmodel = fitlm(X_lin,y_lin(1:end,n));
    for k = 1:size(y_lin,1)
        corrected_morph(k,n) = linearmodel.Coefficients.Estimate(1) + linearmodel.Residuals.Raw(k);
    end    
end
