
#from espresso.utils cimport ERROR 
cimport numpy as np
import numpy as np


cdef int test():
  cdef double pos[0]
  pos[0]=12
  pos[1]=13
  pos[2]=14
  place_particle(0,pos)
  return 0

cdef class ParticleHandle:
  def __cinit__(self, _id):
#    utils.init_intlist(self.particleData.el)
    init_intlist(&(self.particleData.bl))
    self.id=_id

  cdef int update_particle_data(self) except -1:
#    utils.realloc_intlist(self.particleData.el, 0)
    realloc_intlist(&(self.particleData.bl), 0)
      
    if get_particle_data(self.id, &self.particleData):
      raise Exception("Error updating particle data")
    else: 
      return 0

  property pos:
    def __set__(self, _pos):
      cdef double mypos[3]
      for i in range(3):
        mypos[i]=_pos[i]
      place_particle(self.id, mypos)
    def __get__(self):
      self.update_particle_data()
      print  self.particleData.r.p[1]
      return np.array([self.particleData.r.p[0], self.particleData.r.p[1], self.particleData.r.p[2]])
#    def __repr__():
#      return  np.array([self.particleData.r.p[0], self.particleData.r.p[1], self.particleData.r.p[2]]).__repr__()
 

