package dev.mvc.resort_v1sbm3a;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ComponentScan;

@SpringBootApplication
@ComponentScan(basePackages = {"dev.mvc.resort_v1sbm3a"})
public class ResortV1sbm3aApplication {

	public static void main(String[] args) {
		SpringApplication.run(ResortV1sbm3aApplication.class, args);
	}

}
