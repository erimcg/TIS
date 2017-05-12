# TIS, the Thoracic Identification System

TIS is a thoracic signal biometric identification program written in matlab.  The software was orignally written for the Intelligence Community under an IC Fellowship grant (2011 - 2013) at Clarkson University. The program works on ECG and carotid pulse signals. The software computes feature sets following the algorithms in Chen, et.al [1] and classifies the testing feature sets against the training feature sets using either a probabilistic classfier or the support vector machine provided by LIBSVM [2].

## Documentation

Documentation for TIS can be found [here](/docs/TOC.md)

## References

[1] M. Chen; J.A. O'Sullivan; N. Singla; E.J. Sirevaag; S.D. Kristjansson; P.H. Lai;
A.D. Kaplan; J.W. Rohrbaugh;, "Laser Doppler Vibrometry measures of Physiology Function:
Evaluation of Biometric Capabilities," IEEE
Transactions on Information Forensics and Security, v.5., no.3, pp.449-460, 2010.

[2] Chih-Chung Chang and Chih-Jen Lin, LIBSVM : a library for support
vector machines. ACM Transactions on Intelligent Systems and
Technology, 2:27:1--27:27, 2011. Software available at
http://www.csie.ntu.edu.tw/~cjlin/libsvm 
