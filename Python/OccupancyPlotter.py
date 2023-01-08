import csv
import matplotlib.pyplot as plt
from matplotlib.dates import DateFormatter
import datetime 

# Read in the data from the CSV file
data = []
with open('D:/SomewhereProper/Data/Data.csv', 'r') as f:
  reader = csv.reader(f)
  next(reader)  # Skip the header row
  for row in reader:
    data.append((row[0], int(row[1])))

DiamondData = []
with open('D:/SomewhereProper/Data/DataD.csv', 'r') as f:
  reader = csv.reader(f)
  next(reader)  # Skip the header row
  for row in reader:
    DiamondData.append((row[0], int(row[1])))

# Extract the dates and occupancy values
dates = [d[0] for d in data]
occupancy = [d[1] for d in data]
dates2 = [d[0] for d in DiamondData]
occupancy2 = [d[1] for d in DiamondData]

# Convert the dates to a format that Matplotlib can understand
dates = [datetime.datetime.strptime(d, '%m/%d/%Y %H:%M') for d in dates]
dates2 = [datetime.datetime.strptime(d, '%m/%d/%Y %H:%M') for d in dates2]

# Set up the plot
fig, ax = plt.subplots()
ax.plot(dates, occupancy, label='IC')
ax.plot(dates2,occupancy2,"orange", label='Diamond')
ax.set_xlabel('Time of Day')
ax.set_ylabel('Occupancy')
ax.set_title('Occupancy over Time')
plt.legend()

# Set the x-axis tick labels to show just the hour
formatter = DateFormatter('%H')
ax.xaxis.set_major_formatter(formatter)
plt.xticks(rotation=45)

plt.show()