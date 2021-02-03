import numpy as np
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D
import csv 
import sys #used for passing in the argument
import warnings

class MeshSmoothing:
  def __init__(self):
      self.vertices = []

  def lowpass_mesh_smoothing(self,vertices, triangles, num_iter, lmda, mu):

    point_connections = {}
    #keys = (index_of_vertex) 
    #values = [(x1,y1,z1), (x2,y2,z2), ... ]

    #Make sure all vertices are kept as tuples

    # 1. Populate point_connections with all connected points, using only triangles[] (sort)
    for t in triangles:
      #iterate through 3 elements of list t
      #for each of the 3 elements, add the other 2 points to Map at that point
      for element in t:
        values = point_connections.get(element,'NULL') 
        t_newlist = [x for x in t if x != element]

        if values == 'NULL':
          #remove element from t
          new_pc = {element: t_newlist}
          point_connections.update(new_pc)
        else:
          #add 
          for item in t_newlist:
            if item not in values:
              #print("Item is in array already.")
              values.append(item)
          new_pc = {element: values}
          point_connections.update(new_pc)
  
    # for key, value in point_connections.items():
    #   print(key, ' : ', value)
  
    # 2. For each vertex in vertices, search point_connections. Apply smoothing function to all the values neighbouring.
    for x in range(0,num_iter):

      vertices=np.array(vertices,float)

      for idx, vertex in enumerate(vertices):
      # for vertex in vertices: #USE INDEX INSTEAD
        connections = point_connections.get(str(idx+1),'NULL') #search list of connected triangles and ref to index
        if connections != 'NULL':
        #connections holds the index of all the neighbours
          sum_x, sum_y, sum_z = 0, 0, 0
          #print(connections)
          #Defining the weighting factor
          n = len(connections)
          w = 1/n

        #Lambda Step
          for nbr in connections: 
            nbr = int(nbr) - 1 #as vertices goes from 0...n-1, connections from 1..n
            sum_x += w*(vertices[nbr][0] - vertex[0])
            sum_y += w*(vertices[nbr][1] - vertex[1])
            sum_z += w*(vertices[nbr][2] - vertex[2])

          vertex[0] = vertex[0] + lmda*sum_x 
          vertex[1] = vertex[1] + lmda*sum_y 
          vertex[2] = vertex[2] + lmda*sum_z 

          #Lowpass mu step
          for nbr in connections:
            nbr = int(nbr) - 1 #as vertices goes from 0...n-1, connections from 1..n
            # sum += w*(nbr - vertex)
            sum_x += w*(vertices[nbr][0] - vertex[0])
            sum_y += w*(vertices[nbr][1] - vertex[1])
            sum_z += w*(vertices[nbr][2] - vertex[2])

          vertex[0] = vertex[0] + mu*sum_x 
          vertex[1] = vertex[1] + mu*sum_y 
          vertex[2] = vertex[2] + mu*sum_z 

        vertices[idx] = vertex

    self.vertices = vertices #save vertices to be accessed again later

#Data plotter

def data_plotter(data,name):
  # data = [[x1, y1, z1], [x2, y2, z2], ...]]

  fig = plt.figure()
  ax = fig.add_subplot(111, projection='3d')
  
  data = np.array(data)
  data = data.astype(float)

  x = data[:,0]
  y = data[:,1]
  z = data[:,2]

  ax.scatter(x, y, z, c='r', marker='o')

  ax.set_xlabel('X Label')
  ax.set_ylabel('Y Label')
  ax.set_zlabel('Z Label')

  plt.savefig(name) #save figures as defined by name variable

# DATA READER

warnings.filterwarnings("ignore")


vertices = []
file1_name = "data/example_vertices.csv" #filename is argument 1

with open(file1_name, 'rU') as f:  #opens PW file
    reader = csv.reader(f)
    vertices = list(list(rec) for rec in csv.reader(f, delimiter=',')) #reads csv into a list of lists

    #for row in vertices:
        #print row[0] #this alone will print all the computer names
        #print(row)
        #for point_index in row: #Trying to run another for loop to print the usernames
            #print(point_index)


triangles = []
file2_name = "data/example_triangles.csv" #filename is argument 1

with open(file2_name, 'rU') as f:  #opens PW file
    reader = csv.reader(f)
    triangles = list(list(rec) for rec in csv.reader(f, delimiter=',')) #reads csv into a list of lists

    #for row in triangles:
        #print row[0] #this alone will print all the computer names
        #print(row)
        #for point_index in row: #Trying to run another for loop to print the usernames
            #print(point_index)

ms = MeshSmoothing()
lmda = 0.9
mu = -1.02*lmda

for p in 5,10,25:
  print("Surface mesh of "+str(p)+" iterations")
  print("Before:")
  data_plotter(vertices, 'data/before.png') #before; same for all plots
  ms.lowpass_mesh_smoothing(vertices,triangles,p,lmda,mu)
  print("After:")
  data_plotter(ms.vertices,('data/after'+str(p)+'_.png')) #after; changes depending on iteration selection. Labelled accordingly.
  print(ms.vertices.shape)
  ms.vertices = [] #reset vertices after each plot