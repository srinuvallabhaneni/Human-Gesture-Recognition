# Human-Gesture-Recognition
Gesture Recognition using feature extraction and Feature selection methods

[Report](https://github.com/srinuvallabhaneni/Human-Gesture-Recognition/blob/master/Report.pdf)

## Introduction:
The aim of this project is to use Feature extraction (DWT, PDS, FFT, RMS, STD) and Feature Selection (PCA, LDA) methods to extract 5 most discriminating features out of Human Gesture data from 37 users, which is collected using myo sensor bands. And then classified them using CNN, SVM, and Decision tree algorithms using accuracy and precision measures. And then finally to select the best feature among the given features.

## Data Preprocessing:
According to the ground truth folder provided in the data set. We identified the start and end rate of the eating action. We considered the formula **(fps*frame start)/time elapsed** and **(fps*frame end)/time elapsed** to obtain the starting and ending index of eating action and we labeled it as 1, where 1 is the label that is used to represent the eating data. Initially all the data is labelled 0 where 0 represents the label of non-eating data. Now after the above process is done, we obtain the class labels corresponding to each action performed by the user.

    Implemented: PCA and Used Evaluate funtion for calculating the accuracy measures
    
 ### Feature matrix:
**Case1**

        PCA is applied on the user separately and PCA components are obtained and the label obtained in the 
        preprocessing is also saved to the new feature matrix. The same is repeated for every other user.Later
        it is passed to the classification methods such that 60 percent is for training and other 40 percent 
        for testing.

**Case2**

        PCA is applied on the user by concatenating all the data and PCA components for the whole data
        are obtained. the label obtained in the preprocessing is also saved to the new feature matrix.
        Later it is passed to the classification methods such that 60 percent is for training and other 
        40 percent for testing.
        
## Conclusion:
Based on the results, for the given dataset Clasification accuracy is best for Neural network when compared to other classification methods such as Decision trees, SVM (Support Vector machine).

[Relavant graphs and conclusions are presented in the Report](https://github.com/srinuvallabhaneni/Human-Gesture-Recognition/blob/master/Report.pdf)

