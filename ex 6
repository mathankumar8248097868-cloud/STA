1.java

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;

public class ShopEasyPerformanceTest {

    public static void main(String[] args) {

        ChromeOptions options = new ChromeOptions();
        options.addArguments("--remote-allow-origins=*");

        WebDriver driver = new ChromeDriver(options);

        long startTime, endTime, pageLoadTime;

        try {

            // ================= REGISTER PAGE =================
            startTime = System.currentTimeMillis();
            driver.get("https://mathankumar8248097868-cloud.github.io/ShopEasy/register.html");
            driver.findElement(By.id("regName"));
            endTime = System.currentTimeMillis();

            pageLoadTime = endTime - startTime;
            System.out.println("Register Page Load Time: " + pageLoadTime + " ms");


            // ================= INDEX PAGE =================
            startTime = System.currentTimeMillis();
            driver.get("https://mathankumar8248097868-cloud.github.io/ShopEasy/index.html");
            driver.findElement(By.className("product"));
            endTime = System.currentTimeMillis();

            pageLoadTime = endTime - startTime;
            System.out.println("Index Page Load Time: " + pageLoadTime + " ms");


            // ================= ORDERS PAGE =================
            startTime = System.currentTimeMillis();
            driver.get("https://mathankumar8248097868-cloud.github.io/ShopEasy/orders.html");
            driver.findElement(By.id("orderList"));
            endTime = System.currentTimeMillis();

            pageLoadTime = endTime - startTime;
            System.out.println("Orders Page Load Time: " + pageLoadTime + " ms");


            // ================= BILL PAGE =================
            startTime = System.currentTimeMillis();
            driver.get("https://mathankumar8248097868-cloud.github.io/ShopEasy/sbill.html");
            driver.findElement(By.id("billContent"));
            endTime = System.currentTimeMillis();

            pageLoadTime = endTime - startTime;
            System.out.println("Bill Page Load Time: " + pageLoadTime + " ms");

        } catch (Exception e) {
            System.out.println("Test Failed");
            e.printStackTrace();
        }

    }
}
