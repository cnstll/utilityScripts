#!/bin/bash

classNameToUpper=$(echo $class | tr '[:lower:]' '[:upper:]')

if [ -z ${class+x} ];
then echo "Please provide a class name:"
	 echo "class=<className> ./generateCanonicClass.sh"
	 exit 1;
fi

if [ -z ${dir+x} ];
then 
	read -p "Do you want to create the files of the class in a specific directory? (Y/N): " confirm
	if [[ ! $confirm == [yY] && ! $confirm == [yY][eE][sS] ]]
	then (dir="" && echo "Class files created in active directory");
	else
		read -p "Directory name: " directory
		if [ ! -d ${directory+x} ] 
			then read -p "Input directory does not exist, do you want to create it? (Y/N): " confirm2
			if	[[ $confirm == [yY] || $confirm == [yY][eE][sS] ]]
				then echo "Closing..." && exit 1
			else
				mkdir ${directory};
				dir="${directory}/";
			fi
		else
			dir="${directory}/";
		fi
	fi
else dir="${dir}/" && echo "Class files created in ${dir}";
fi

#touch ${dir}${class}.hpp
cat > ${dir}${class}.hpp << END 
#ifndef ${classNameToUpper}_HPP
#define ${classNameToUpper}_HPP

class $class {

	public:

		$class( void );
		$class( $class const & src );
		~$class( void );

		$class	&operator= ( $class const & rhs );

	private:

};
#endif
END

#touch ${dir}${class}.cpp
cat > ${dir}${class}.cpp << END 
#include "${class}.hpp"
#include <iostream>

$class::$class( void ){

	std::cout << "${class} - Default constructor called\n";
	return ;
};

$class::$class( $class const & src ){

	std::cout << "${class} - Copy constructor called\n";
	*this = src;
	return ;
};

$class::~$class( void ){

	std::cout << "${class} - Destructor called\n";
	return;
};

$class	&$class::operator= ( $class const & rhs ){

	this-> = ;
	return *this;
};

END
