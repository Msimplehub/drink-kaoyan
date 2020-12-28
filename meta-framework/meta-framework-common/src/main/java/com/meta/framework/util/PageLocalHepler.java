package com.meta.framework.util;


import com.github.pagehelper.Page;

public class PageLocalHepler {
    private static ThreadLocal<Page> pageThreadLocal = new ThreadLocal<>();

    public static void setPageLocal(Page page){
        pageThreadLocal.set(page);
    }

    public static Page getPageLocal(){
        return pageThreadLocal.get();
    }

    public static Long getTotal(){
        return pageThreadLocal.get() != null ? pageThreadLocal.get().getTotal() : 0;
    }

    public static void clear(){
        pageThreadLocal.remove();
    }

}
