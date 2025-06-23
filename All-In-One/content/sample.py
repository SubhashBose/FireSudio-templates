
import pandas as pd
import matplotlib.pyplot as plt

def plot_csv(filepath):
    df = pd.read_csv(filepath, header=None)
    x = df.iloc[:, 0]
    y = df.iloc[:, 1]
    error = df.iloc[:, 2]
    plt.errorbar(x, y, yerr=error, fmt='o')
    plt.xlabel('X')
    plt.ylabel('Y')
    plt.title('X vs Y with Error Bars')
    plt.show()

plot_csv('sample.csv')
