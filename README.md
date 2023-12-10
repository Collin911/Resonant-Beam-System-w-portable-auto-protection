# Portable-Auto-Protection-RBS
Explore my paper with IEEEXplore https://ieeexplore.ieee.org/document/10192905

Cite our work with BibTex:
```LaTex
@ARTICLE{10192905,
  author={Xia, Shuaifan and Liu, Qingwen and Liu, Mingqing and Fang, Wen and Xiong, Mingliang and Bai, Yunfeng and Li, Xiaozhe},
  journal={IEEE Internet of Things Journal}, 
  title={Auto-Protection for Resonant Beam SWIPT in Portable Applications}, 
  year={2023},
  volume={},
  number={},
  pages={1-1},
  doi={10.1109/JIOT.2023.3298521}}
```

In this paper, we proposed an auto-protection scheme for the resonant beam system, with which potential simultaneous lightwave information and power transfer (SLIPT) could be realized. With our scheme, the intra-cavity laser can be automatically shut off when foreign objects invade into the optical path, leaving minimum radiance exposure onto the invading object, ensuring enhanced safety. We employed phase compensation scheme to ensure the availability under portable application scenario. 

To run the simulation for 2D lightwave field transmission, open *exp_V2.m*, setup parameters (there are also some global parameters in Para_FFTAlgorithm), and run. 
With the results obtained by exp_V2.m, additional SWIPT metrics can be calculated with *exp_SWIPT.m*

There are some **REDUNDANT** files, I have removed several deprecated function files in the recent push, but no guarantee for completion. You can check from exp_v2 stack by stack, if a function is never called, simply delete it will be ok. 

P.S. The *Para_FFTAlgorithm_V2* is never called, but it can help you to calculate the required sampling rate automatically with parameters fed in. You can try to replace all of the *Para_FFTAlgorithm* with the V2 version and provide parameters required. There are too many calls for *Para_FFTAlgorithm* and I'm too lazy to replace it :P
