package com.meta.crm;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.jdbc.DataSourceAutoConfiguration;

/**
 * 启动程序
 *
 * @author ruoyi
 */
@SpringBootApplication(exclude = {DataSourceAutoConfiguration.class}, scanBasePackages = "com.meta")
public class CrmApplication {
	public static void main(String[] args) {
		// System.setProperty("spring.devtools.restart.enabled", "false");
		try{
			SpringApplication.run(CrmApplication.class, args);
		}catch (Exception e){
			e.printStackTrace();
		}
		System.out.println("(♥◠‿◠)ﾉﾞ  x-men 启动成功   ლ(´ڡ`ლ)ﾞ  \n" +
				" ___    ___             _____ ______   _______   ________      \n" +
				"|\\  \\  /  /|           |\\   _ \\  _   \\|\\  ___ \\ |\\   ___  \\    \n" +
				"\\ \\  \\/  / /___________\\ \\  \\\\\\__\\ \\  \\ \\   __/|\\ \\  \\\\ \\  \\   \n" +
				" \\ \\    / /\\____________\\ \\  \\\\|__| \\  \\ \\  \\_|/_\\ \\  \\\\ \\  \\  \n" +
				"  /     \\/\\|____________|\\ \\  \\    \\ \\  \\ \\  \\_|\\ \\ \\  \\\\ \\  \\ \n" +
				" /  /\\   \\                \\ \\__\\    \\ \\__\\ \\_______\\ \\__\\\\ \\__\\\n" +
				"/__/ /\\ __\\                \\|__|     \\|__|\\|_______|\\|__| \\|__|\n" +
				"|__|/ \\|__|                                                    "
		);
	}
}
