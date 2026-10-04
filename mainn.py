import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import LabelEncoder, StandardScaler
from sklearn.ensemble import RandomForestClassifier
from sklearn.metrics import confusion_matrix, accuracy_score, classification_report

file_path = r'C:\Users\hp\Downloads\Bank+Customer+Churn\Bank_Churn.csv'  # Load your dataset here
df = pd.read_csv(file_path)  # Load your dataset here
df = df .drop(['CustomerId', 'Surname'], axis=1)  # Drop unnecessary columns

x = df.drop('Exited',axis =1)  # Features
y = df['Exited']  # Target variable
print('Features Shape:',x.shape)
print('Target Shape:',y.shape)

le = LabelEncoder()  # Initialize LabelEncoder
x['Geography'] =le.fit_transform(x['Geography'])  # Encode categorical variable 'Geography'
x['Gender'] = le.fit_transform(x['Gender'])  # Encode categorical variable 'gender'
print(x.head())

x_train,x_test,y_train,y_test = train_test_split(x,y,test_size =0.2 ,random_state = 42)
print('Train Shape:',x_train.shape)
print('Test Shape:',x_test.shape)

Model = RandomForestClassifier(random_state=42)
Model.fit(x_train,y_train)  # Train the model
y_pred = Model.predict(x_test)  # Make predictions on the test set
print('classification report:',classification_report(y_test,y_pred))
print('Accuracy Score:', accuracy_score(y_test, y_pred))

importances = Model.feature_importances_  # Get feature importances
feature_importances_df = pd.DataFrame({
    'feature': x.columns,
    'importances': importances
}).sort_values(by = 'importances', ascending = False)
print(feature_importances_df)

import joblib
joblib.dump(Model, 'bank_churn_model.pkl')
joblib.dump(le, 'label_encoder.pkl')
print('Model Saved Successfully')