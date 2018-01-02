import hy
from trytond.pool import Pool
from . import motto


def register():
    Pool.register(
        motto.Motto,
        module='motto', type_='model')
