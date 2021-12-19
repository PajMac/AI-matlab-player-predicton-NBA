function layer = GradientDescent( layer, layerInput, learningRate )
    
    numLayers = numel( layer ); %Poèet vrstvev v síti

    %Úprava vah pro (i-tou) vrstvu
    for i = 1:numLayers
        
        numNeurons = layer( i ).NumNeurons;
        
        %Uprava vah pro každý (j-tý) neuron v jedné vrstvì:
        for j = 1:numNeurons
            
            %Extrakce parametrù ze sítì
            delta = layer( i ).Delta( j );
            weights = layer( i ).Weights( j, : );
            derivActivation = layer( i ).DerivActivation( j ); % derivace aktivacni funkce neuronu
            
            %Odhad celkové chyby neuronu
            gradE = (-delta) .* derivActivation .* layerInput;
            
            %Aktualizace vah ve smìru nejstrmìjšího sestupu gradientu kriteriální funkce
            weights = weights - learningRate * gradE;
            
            %Uložení aktualizovaných vah do struktury sítì
            layer( i ).Weights( j, : ) = weights;

        end
        
        layerInput = [ 1 layer( i ).Output ];
        
    end

end