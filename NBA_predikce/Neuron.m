function y = Neuron(x, weights, activationType, T)

if nargin<4
   T = 0.5; % pokud konstanta T (ovlivnuje strmost sigmoidy) neni zadana uzivatelem, nastav hodnotu 0.5
end
        
    %Výběr aktivační funkce neuronu
    switch activationType
        case 'step'
            NeuronOutput = @StepFunc;
        case 'sigmoid'
            NeuronOutput = @SigmoidFunc;
        case 'linear'
            NeuronOutput = @LinearFunc;
        otherwise
            error('Unknown activation function type.')
    end        
    
    %Rozšíření vstupních dat o násobitel (1) prahové hodnoty
    numFeatures = size( x, 1 );
    biasCoeff = ones( numFeatures, 1 );
    x = [ biasCoeff, x ];
       
    a = weights*x'; %Vektorizovaný vypocet aktivace neuronu (skalarni soucin vektoru vah a priznaku)
    y = NeuronOutput( a, T ); %Vypocet vystupu neuronu - transformace aktivace pomoci vybrane aktivacni funkce    
    y = y';
    
end


%% Skoková aktivační funkce
function y = StepFunc( a, ~ )

    y = a;
    y( y >= 0 ) = 1;
    y( y < 0) = 0;    
    
end


%% Sigmoidální aktivační funkce
function y = SigmoidFunc( a, T )
    
    y = 1 ./ (1 + exp( -a/T )); % alternativni vypocet: y = logsig(a);
    
end

%% Linearni aktivační funkce
function y = LinearFunc(a,~)

    y = a;

end


