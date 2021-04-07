import os

from setuptools import find_packages, setup

docs_require = []

tests_require = []

extras_require = {
}
extras_require['all'] = [req for exts, reqs in extras_require.items() for req in reqs]

setup_requires = [
    'pytest-runner>=5.2',
]

install_requires = [
    "geopandas",
    "rasterio",
    "numba",
    "click",
    "stac.py"
]

packages = find_packages()

g = {}
with open(os.path.join('rep_cbers_cube', 'version.py'), 'rt') as fp:
    exec(fp.read(), g)
    version = g['__version__']

setup(
    name='rep_cbers_cube',
    version=version,
    description=__doc__,
    keywords=['reproducibility', 'cbers data cube'],
    license='MIT',
    author='INPE',
    packages=packages,
    zip_safe=False,
    include_package_data=True,
    platforms='any',
    extras_require=extras_require,
    install_requires=install_requires,
    setup_requires=setup_requires,
    tests_require=tests_require,
    entry_points={
        'console_scripts': [
            'cbersdatacube = rep_cbers_cube.cli:cli'
        ]
    },
    classifiers=[
        'Development Status :: 3 - Alpha',
        'Environment :: Console',
        'Environment :: Console :: Curses  ',
        'Intended Audience :: Education',
        'Intended Audience :: Science/Research',
        'Intended Audience :: Developers',
        'License :: OSI Approved :: MIT License',
        'Operating System :: OS Independent',
        'Programming Language :: Python :: 3 :: Only',
        'Topic :: Scientific/Engineering :: GIS',
        'Topic :: Software Development :: Libraries :: Python Modules',
        'Topic :: Utilities',
    ],
)