function layer = GradientDescent( layer, layerInput, learningRate )
    
    numLayers = numel( layer ); %Po�et vrstvev v s�ti

    %�prava vah pro (i-tou) vrstvu
    for i = 1:numLayers
        
        numNeurons = layer( i ).NumNeurons;
        
        %Uprava vah pro ka�d� (j-t�) neuron v jedn� vrstv�:
        for j = 1:numNeurons
            
            %Extrakce parametr� ze s�t�
            delta = layer( i ).Delta( j );
            weights = layer( i ).Weights( j, : );
            derivActivation = layer( i ).DerivActivation( j ); % derivace aktivacni funkce neuronu
            
            %Odhad celkov� chyby neuronu
            gradE = (-delta) .* derivActivation .* layerInput;
            
            %Aktualizace vah ve sm�ru nejstrm�j��ho sestupu gradientu kriteri�ln� funkce
            weights = weights - learningRate * gradE;
            
            %Ulo�en� aktualizovan�ch vah do struktury s�t�
            layer( i ).Weights( j, : ) = weights;

        end
        
        layerInput = [ 1 layer( i ).Output ];
        
    end

end