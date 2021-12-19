function layer = ForwardPropagation( layer, layerInput )
% Funkce pro výpoèet dopøedné aktivace sítì.
% Vstup:    layer:          struktura s jednotlivými vrstvami sítì a jejich parametry
%           layerInput:     aktuální trénovací èi testovací vektor pøíznakù
% Výstup:   layer:          vrstvy sítì s aktualizovanými parametry

% Pro každou vrstvu sítì potøebujeme urèit výstup všech neuronù (fce Neuron()) a parciální
% derivaci aktivaèní funkce podle vah w (fce SigmoidGradient() ci jina)
    
    numLayers = numel( layer ); %Poèet vrstvev v síti

    for i = 1:numLayers
        weights = layer( i ).Weights;
        T = layer( i ).T;
        
        % Požadované výstupy algoritmu
        output = Neuron( layerInput, weights, 'sigmoid', T );
        derivActivation = SigmoidGradient( output, T ); % vypocet derivace aktivacni funkce pomoci funkce SigmoidGradient
        
        % Aktualizace vstupu do další vrstvy
        layerInput = output;
        
        % Uložení výsledkù do struktury sítì
        layer( i ).Output = output;
        layer( i ).DerivActivation = derivActivation;
    end

end