function layer = BackPropagation( layer, delta )

    numLayers = numel( layer ); %Poèet vrstvev v síti
    layer(end).Delta = delta; % Uložení chyby na vystupnich neuronech
    
    for i = numLayers:-1:2
        weights = layer( i ).Weights( :, 2:end );
    	delta = delta * weights; % Odhad chyb na neuronech skryte vrstvy
        
        layer( i - 1 ).Delta = delta;
    end

end