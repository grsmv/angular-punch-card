module.exports = function (grunt) {
    grunt.initConfig({
        pkg: grunt.file.readJSON("package.json"),

        sass: {
            dist: {
                options: {
                    style: "expanded"
                },
                files: {
                    "dist/punch-card.css": "src/punch-card.scss"
                }
            }
        },

        coffee: {
            compile: {
                files: {
                    "dist/punch-card.js": "src/punch-card.coffee"
                }
            }
        },

        watch: {
          scripts: {
            files: ['src/punch-card.coffee'],
            tasks: ['coffee']
          },
          style: {
            files: ['src/punch-card.scss'],
            tasks: ['sass']
          }
        }
    });

    grunt.loadNpmTasks("grunt-contrib-coffee");
    grunt.loadNpmTasks("grunt-contrib-sass");
    grunt.loadNpmTasks("grunt-contrib-watch");

    grunt.registerTask('default', ['watch']);

    grunt.registerTask("pack", "Creating production package", function () {
        grunt.task.run("coffee");
        grunt.task.run("sass");
    });
};
