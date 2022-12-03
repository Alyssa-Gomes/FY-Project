# Weight Reduction of a Speed Reducer using Modified Particle Swarm Optimization and Shuffled Frog Leaping Algorithm

### Objectives
- Identify the minimal cost function evaluation for the given constraints
- Identify the optimal combination of algorithm specific parameters (in this case - 𝜔, c<sub>1</sub>, c<sub>2</sub>) for the problem

### Problem Diagram
<img src="/Figure 6.png" width="350px" title="Golinski speed reducer diagram">

### Results
- The cost function evaluation obtained using modified PSO and SFLA were 8.1790% lower than the result obtained using the Taguchi method by Ku et al. (1998), 1.1619% (Crude Monte-Carlo method) and 13.41% (Stray Process) lower than that obtained by Jan Golinski (1970), and around 11% lower than results obtained by other researchers. 
- Optimal parameter combinations:
  - PSO: 𝜔 = 0.5, c<sub>1</sub> = 1.5 and c<sub>2</sub> = 1.5, for a population size of 30
  - SFLA:  𝜔 = 1, c<sub>1</sub> = 2 and c<sub>2</sub> = 0.5, for a population size of 150 (15 memeplexes with 10 frogs each)
- Modified SFLA generally takes lesser number of convergence iterations (CI) on average as compared to modified PSO.
- The average run time (RT) for the same number of iterations (1000) is greater for modified SFLA. 


### Tools Used
- [MATLAB](https://www.mathworks.com/products/matlab.html) - A programming and numeric computing platform
  - To implement PSO and SFLA algorithms
- [Python](https://www.python.org/) - A high-level, general-purpose programming language
  - To statistically analyse project results
  - [NumPy](https://numpy.org/) - A fundamental package for scientific computing in Python 
  - [Matplotlib](https://matplotlib.org/stable/index.html) - A comprehensive library for creating static, animated, and interactive visualizations in Python
  - [Pandas](https://pandas.pydata.org/) - a fast, powerful, flexible and easy to use open source data analysis and manipulation tool
  - [Seaborn](https://seaborn.pydata.org/) - a Python data visualization library based on matplotlib
  
### Other Resources Used
- [Optimization Test Problems](https://www.sfu.ca/~ssurjano/optimization.html) - For benchmark functions

### References
- Ku, K. J., Rao, S. S., & Chen, L. (1998). Taguchi-aided search method for design optimization of engineering systems. Engineering Optimization, 30(1), 1–23. 
[https://doi.org/10.1080/03052159808941235](https://doi.org/10.1080/03052159808941235)
- Jan Golinski. (1970). Optimal synthesis problems solved by means of nonlinear programming and random methods. Journal of Mechanisms, 5(3), 287–309. [https://doi.org/10.1016/0022-2569(70)90064-9](https://doi.org/10.1016/0022-2569(70)90064-9)
- Heris, M. K. (2015). Shuffled Frog Leaping Algorithm in MATLAB. Yarpiz. [https://yarpiz.com/71/ypea109-shuffled-frog-leaping-algorithm](https://yarpiz.com/71/ypea109-shuffled-frog-leaping-algorithm)
- Heris, M. K. (2016). Particle Swarm Optimization (PSO) in MATLAB - Video Tutorial. Yarpiz. [https://yarpiz.com/440/ytea101-particle-swarm-optimization-pso-in-matlab-video-tutorial](https://yarpiz.com/440/ytea101-particle-swarm-optimization-pso-in-matlab-video-tutorial)
- [Kotecha, P. (2020, March 11). Lec 22 : Constraint-Handling in Metaheuristic Techniques - YouTube. NPTEL IIT Guwahati](https://www.youtube.com/watch?v=ftOzxva86rA&list=PLwdnzlV3ogoUuROTSTBM2mUgtiKIrRn_5&index=24)
