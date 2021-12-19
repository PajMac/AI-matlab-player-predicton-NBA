function layer = ForwardPropagation( layer, layerInput )
% Funkce pro v�po�et dop�edn� aktivace s�t�.
% Vstup:    layer:          struktura s jednotliv�mi vrstvami s�t� a jejich parametry
%           layerInput:     aktu�ln� tr�novac� �i testovac� vektor p��znak�
% V�stup:   layer:          vrstvy s�t� s aktualizovan�mi parametry

% Pro ka�dou vrstvu s�t� pot�ebujeme ur�it v�stup v�ech neuron� (fce Neuron()) a parci�ln�
% derivaci aktiva�n� funkce podle vah w (fce SigmoidGradient() ci jina)
    
    numLayers = numel( layer ); %Po�et vrstvev v s�ti

    for i = 1:numLayers
        weights = layer( i ).Weights;
        T = layer( i ).T;
        
        % Po�adovan� v�stupy algoritmu
        output = Neuron( layerInput, weights, 'sigmoid', T );
        derivActivation = SigmoidGradient( output, T ); % vypocet derivace aktivacni funkce pomoci funkce SigmoidGradient
        
        % Aktualizace vstupu do dal�� vrstvy
        layerInput = output;
        
        % Ulo�en� v�sledk� do struktury s�t�
        layer( i ).Output = output;
        layer( i ).DerivActivation = derivActivation;
    end

end