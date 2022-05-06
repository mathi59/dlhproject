
## Extracting Schemas from Thought Records 
#### (Reproducibility project)
### Team: 165 Paper ID: 117
#### Mathi Manickam (mm59@illinois.edu) Aruna Gomatam(gomatam2@illinois.edu)
### Introduction
This study is related to a specific therapeutic task in the field of cognitive psychotherapy based
on A. T. Beck’s cognitive theory. Cognitive therapy employs the study of thought records of
patients who have an overly negative view of them-selves, the world, or the future. The theory postulates that our fundamental core beliefs set from our child hood years affect the way we instantly appraise a situation. It is believed that getting an understanding of these core beliefs or cognitive schemas would enable specialists to provide better care to their patients. The objective of the study was to see whether the underlying maladaptive schemas of a thought record utterance can be scored by a machine.

### Citation to the original paper
Journal PLOS ONE [paper](https://doi.org/10.1371/journal.pone.0257832)

### Link to the original paper's data and analysis scripts repository 
Data Availability: All data and analysis scripts are available from the [4TU.ResearchData repository](https://doi.org/10.4121/16685347) 

### Our github repository 
Journal PLOS ONE [github-repo](https://github.com/mathi59/group165)

### Data download instructions

Our code to reproduce the results of the above study can be done by cloning this directory.

Once you clone this directory it should look like this:
```bash
group165
├── Team165_Extracting_Schemas_From_Thought_Records.ipynb
├── Team165_Generate_Results_From_Models.ipynb
├── README.md
├── Data
│    ├── DatasetsForH1
│    │      ├── H1_test_labels.csv
│    │      ├── H1_test_texts.csv
│    │      ├── H1_train_labels.csv
│    │      ├── H1_train_texts.csv
│    │      ├── H1_validate_labels.csv
│    │      └── H1_validate_texts.csv
│    ├── glove.6B
│    │      └── glove.6B.100d.txt
└── Data2
     ├── DatasetsForH1
     │      ├── H1_test_labels.csv
     │      ├── H1_test_texts.csv
     │      ├── H1_train_labels.csv
     │      ├── H1_train_texts.csv
     │      ├── H1_validate_labels.csv
     │      └── H1_validate_texts.csv
     ├── glove.6B
     │      └── glove.6B.100d.txt
     ├── mlm_rnn.zip
     ├── PSMs
     │      ├── per_schema_models_0
     │      │      ├── schema_model_Attach.h5
     │      │      ├── ....
     │      │      └── schema_model_OthViews.h5
     │      ├── per_schema_models_1
     │      │     ├── schema_model_Attach.h5
     │      │     ├── ....
     │      │     └── schema_model_OthViews.h5
     │      ├── ...
     │      ├── ...
     │      ├── per_schema_models_29
     │      │      ├── schema_model_Attach.h5
     │      │      ├── ....
     │             └── schema_model_OthViews.h5
     └── MLMs
            ├── mlm_0.h5
            ├── ...
            ├── ...
            └─── mlm_29.h5

```
******  You'll see two data directories in this set. Data directory <i>Data</i> will be used to replicate the entire study and <i>Data2</i> to generate just the results using the pretrained models. The scripts to replicate the entire study and to just generate the results are described in detail in the sections below. 


### Preprocessing instructions

This project has been developed using python3 and Jupyter notebook. 
```bash
The modules used in this project are:
    * numpy
    * pandas
    * gensim
    * statsmodels
    * rsa_nlu
    * tensorflow
    * talos
    * scipy
    * scikit-learn


```

Follow the instructions below to setup the environment.

```bash
# Navigate to the group165 folder 
cd {User_Home}/group165 
```
```bash
# Create condo environment using name py3env
conda create -n py3env python=3.7
```
```bash
# Activate condo environment using the name py3env
conda activate py3env
```
```bash
# Install the following packages using Pip in py3env
pip install numpy==1.21.6 pandas==1.3.5 gensim==3.6.0 statsmodels==0.10.2
pip install rasa-nlu tensorflow==2.8.0 
pip install talos
pip install scipy==1.4.1 scikit-learn==0.23.2

```
```bash
# Install jupyter notebook packages 
conda install -c anaconda ipykernel
python -m ipykernel install --user --name=py3env
pip install jupyter
```

### Reproducing the entire study 
#### (Training code + Evaluation code + Pretrained Models + Results)
<br>
The modules below need to be installed before running the code. (Refer to the <i> Preprocessing Instructions section </i> to install missing packages)
    <ol>
    <li>numpy==1.21.6</li>
    <li>pandas==1.3.5</li>
    <li>gensim==3.6.0</li>
    <li>statsmodels==0.10.2</li>
    <li>rasa-nlu</li>
    <li>tensorflow==2.8.0</li>
    <li>talos</li>
    <li>scipy==1.4.1</li>
    <li>scikit-learn==0.23.2</li>
    </ol>
    
This jupyter notebook <i>Team165_Extracting_Schemas_From_Thought_Records.ipynb</i> contains the sections for the following:
<ol>
<li>Processing the input files (train, validate, test) to get it to the right format</li>
<li>Training the 3 sets of algorithms (kNN, SVM, RNN)</li>
<li>Generating the models for future use (Pretrained models)</li>
<li>Using the generated models to produce the results (Predictions and Confidence Intervals)</li>
</ol>


#### Step 1:

Open a local browser window by running the command
```bash
jupyter notebook
```

#### Step 2:
```bash
Navigate the jupyter tree and open the notebook file Team165_Extracting_Schemas_From_Thought_Records.ipynb
```

#### Step 3:
```bash
Check whether kernel is set to py3env. If not go ahead and set this up manually
```

#### Step 4:
```bash
Run all cells ensuring that the imports check out fine
```

### Reproducing results using pretrained models 
#### (Results only)

<br>
The modules below need to be installed before running the code. (Refer to the <i> Preprocessing Instructions section </i> to install missing packages)
    <ol>
    <li>numpy==1.21.6</li>
    <li>pandas==1.3.5</li>
    <li>gensim==3.6.0</li>
    <li>statsmodels==0.10.2</li>
    <li>rasa-nlu</li>
    <li>tensorflow==2.8.0</li>
    <li>talos</li>
    <li>scipy==1.4.1</li>
    <li>scikit-learn==0.23.2</li>
    </ol>
This jupyter notebook <i>Team165_Extracting_Schemas_From_Thought_Records.ipynb</i> contains the sections for the following:
<ol>
<li>Processing the input files (train, validate, test) to get it to the right format</li>
<li>Training the 3 sets of algorithms (kNN, SVM, RNN)</li>
<li>Generating the models for future use (Pretrained models)</li>
<li>Using the generated models to produce the results (Predictions and Confidence Intervals)</li>
</ol>



This jupyter notebook <i>Team165_Generate_Results_From_Models.ipynb</i> contains the sections for the following:
<ol>
<li>Processing the input files (train, validate, test) to get it to the right format</li>
<li>Using the pretrained models for the 3 sets of algorithms (kNN, SVM, RNN), to produce the results (Predictions and Confidence Intervals)</li>
</ol>

 ****** We have included this additional code (new one) as part of our reproducibility project so that any one interested in just generating the results of the study can easily attempt to do this in a few hours.

#### Step 1:
Open a local browser window by running the command
```bash
jupyter notebook
```

#### Step 2:

```bash
Navigate the jupyter tree and open the notebook file Team165_Generate_Results_From_Models.ipynb
```

#### Step 3:
```bash
Check whether kernel is set to py3env. If not go ahead and set this up manually
```

#### Step 4:
```bash
Run all cells ensuring that the imports check out fine
```
### Table of results

```bash
# Estimates of all models
          kNN_class   kNN_reg       SVC       SVR       PSM       MLM
Attach     0.550705  0.626743  0.647714  0.675340  0.727138  0.686899
Comp       0.690230  0.663091  0.684661  0.640866  0.755107  0.662779
Global     0.401123  0.411444  0.357601  0.489372  0.577940  0.487473
Health     0.742217  0.534902  0.729181  0.349064  0.752872  0.351675
Control    0.107526  0.231541       NaN  0.310007  0.278793  0.314296
MetaCog         NaN  0.104785       NaN  0.114894 -0.012864  0.108215
Others     0.279105  0.243713       NaN  0.185827  0.223674  0.158427
Hopeless   0.484137  0.513825  0.489903  0.535979  0.627562  0.533973
OthViews   0.454565  0.458473  0.476297  0.516635  0.578668  0.504708
```

```bash
#Lower confidence intervals of all models
          kNN_class   kNN_reg       SVC       SVR       PSM       MLM
Attach     0.506610  0.592528  0.606667  0.649722  0.695272  0.661568
Comp       0.643764  0.631965  0.649524  0.614080  0.723876  0.637833
Global     0.332734  0.363976  0.305471  0.451517  0.541899  0.448301
Health     0.654676  0.440834  0.650953  0.308533  0.654251  0.307359
Control    0.018689  0.171817  0.000000  0.259155  0.208185  0.268236
MetaCog    0.000000  0.005652  0.000000  0.055044  0.000000  0.058033
Others     0.000000  0.165796  0.000000  0.142794  0.066163  0.102297
Hopeless   0.437052  0.466884  0.431823  0.509305  0.560763  0.503509
OthViews   0.414239  0.419668  0.425397  0.475484  0.518882  0.473159
```
```bash
#Upper confidence intervals of all models
          kNN_class   kNN_reg       SVC       SVR       PSM       MLM
Attach     0.599736  0.653529  0.678210  0.697454  0.759638  0.719552
Comp       0.725916  0.694682  0.722693  0.674124  0.785342  0.691817
Global     0.464361  0.455419  0.404890  0.516982  0.628235  0.527082
Health     0.810789  0.601932  0.809307  0.395494  0.819880  0.387933
Control    0.177912  0.273330  1.000000  0.345596  0.346432  0.343677
MetaCog    1.000000  0.197388  1.000000  0.155583 -0.009094  0.144963
Others     1.000000  0.307799  1.000000  0.235886  0.331280  0.203079
Hopeless   0.549618  0.559551  0.529388  0.567836  0.681406  0.563676
OthViews   0.514116  0.499502  0.531955  0.550134  0.632585  0.540421
```
