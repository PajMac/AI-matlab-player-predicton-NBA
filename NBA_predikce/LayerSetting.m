function layer = LayerSetting(numNeurons, numFeatures, T)
% Funkce pro vytvoreni struktury site a vychozi (nahodne) nastaveni vah
% neuronu v siti. Defaultne se nastavi i konstanta T, ktera ridi strmost
% sigmoidy (tento parametr bude pouzit pro vypocty v tech vrstvach, v nichz bude pouzita sigmoidalni aktivacni funkce).

layer(1).Weights = rand( numNeurons(1), numFeatures + 1 ); % Vektory vah (vcetne prahu) pro neurony 1. skryte vrstvy (Q1xN+1), N-pocet priznaku, Q1-pocet skrytych neuronu
for i=2:length(numNeurons)
    layer(i).Weights = rand( numNeurons(i), numNeurons(i-1) + 1 ); % Vektory vah (vcetne prahu) pro neurony dalsich vrstev (Q2xQ3+1), Q3 - pocet vystupnich neuronu predchozi vrstvy, Q2 je pocet neuronu v aktualni vrstve
end
for i=1:length(numNeurons)
    layer(i).NumNeurons = numNeurons(i);
    layer(i).T = T;%konstanta, ktera ovlivnuje strmost sigmoidy
end