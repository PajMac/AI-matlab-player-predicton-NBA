clc, clear all, close all
%% načtení a rozdělení dat na vstup a výstup
data = readtable('dataNBA.csv'); %načtení dat
numberRecords = size( data, 1 ); %počet proměnných


data_m = table2array(data( :,3:21) ); %převod na vektor

for c = 1 : size(data_m,2) %nahrazení NaN hodnot
     for r = 1:size(data_m,1)
         if (isnan(data_m(r,c)))
             data_m(r,c) = mean(data_m(:,c),'omitnan');
         end
     end
end
  
yData = table2array(data(:,22)); %načtení výstupu
vystup = zeros(1,size(yData,1)); %prázdná matice
yData = cell2table(yData); %převod výstupu

for n = 1:size(data_m,1) %pokud vystup == yes, nahraď 1
    if strcmp(yData{n,1}, 'yes')
        vystup(n)= 1;
    else
        vystup(n)= 0;
    end
end

vystup = vystup';
yData = vystup; % definování výstupních hodnot
%% PCA metoda, předzpracování dat
data_m = zscore(data_m); %sntandardizace dat

covX = CovarianceMatrix(data_m);


%Spektrální rozklad kovarianční matice
[eigenVectors, eigenValues] = eig(covX);

%Seřazení vlastních čísel
eigenValues = diag(eigenValues);
[eigenValues, sortedIdx] = sort(eigenValues, 'descend');

%Seřazení vlastních vektorů
eigenVectors = eigenVectors(:,sortedIdx);

threshold = 95; %nastavení prahu
numComponents = SelectComponents(eigenValues, threshold); %stanovení počtu proměnných

%Rozklad dat do prostoru hlavních komponent
pcData = DataDecomposition(data_m, eigenVectors(:,1:numComponents));

[corrArray, pArray] = corrcoef(data_m); % pro kazdy priznak -> vypocet korelace s ostatnimi priznaky
figure, imagesc(corrArray);

%% klasifikace objektu

xTrain = pcData; %nastavení trénovacích vstupních hodnot
yTrain = yData; %nastavení trénovacích výstupních hodnot

%hyperparametry sítě
numNeurons = [10;1]; 

% Parametry učení
maxEpoch = 150;      % maximalni pocet epoch uceni
maxMse = 0.01;      % maximalni pripustna odchylka
learningRate = 0.1; % konstanta uceni (krok uceni), ovlivnuje rychlost uceni
T = 0.5;            % konstanta urcujici strmost sigmoidalni aktivacni funkce (pokud je pouzita), MUZE SE MENIT?

%Permutace trenovacich vzoru a nastaveni krizove validace modelu
numObject = size(xTrain,1);
permutateIdx = randperm(numObject); 
xTrain = xTrain(permutateIdx,:);
yTrain = yTrain(permutateIdx,:);

K = 1; % zadani poctu validacnich iteraci (k-fold krizova validace) - a tim i validacnich mnozin
numObjectFold = floor(numObject/K); % pocet objektu v jedne validacni mnozine
xTrain = xTrain(1:numObjectFold*K,:); % vyber vsech objektu pro trenovani
yTrain = yTrain(1:numObjectFold*K,:);

%Trenovani a vyhodnoceni modelu v modu k-nasobne krizove validace
%resultArray = zeros(K,5); 
j=1;
for i=1:K
    testIdx = j:numObjectFold*i; % indexy testovacich vzoru v dane validacni iteraci
    trainIdx = 1:numObjectFold*K;%trainIdx(testIdx)=[]; % intexy trenovacich vzoru v dane validacni iteraci (vsechny vzory krome spadajicich do testovaci mnoziny)
    
    xTestFold = xTrain(testIdx,:); % testovaci vzory v dane iteraci
    yTestFold = yTrain(testIdx,:); 
    xTrainFold = xTrain(trainIdx,:); % trenovaci vzory v dane iteraci
    yTrainFold = yTrain(trainIdx,:);
    
    [outPerformanceTrain(i,:) outPerformanceTest(i,:)]= trainBPNN(xTrainFold, yTrainFold, xTestFold, yTestFold, numNeurons, maxEpoch, maxMse, learningRate, T);
    
    j=numObjectFold*i+1;
end

disp({'ACC', 'SE', 'SP', 'PPV', 'F1', 'Trénovací data'})
disp({num2str(mean(outPerformanceTrain)); num2str(std(outPerformanceTrain))})
disp({'ACC', 'SE', 'SP', 'PPV', 'F1', 'Testovací data'})
disp({num2str(mean(outPerformanceTest)); num2str(std(outPerformanceTest))})

