cmake_minimum_required(VERSION 3.10)
project(generate_test_wrapper)
enable_language(Fortran)
list(APPEND CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/)
include(parse_tests_file.cmake)
parse_tests_file(m_tests.f90)
