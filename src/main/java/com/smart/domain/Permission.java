package com.smart.domain;

public class Permission {
    private Integer permissId;
    private  String permissName;
    private  String permissDes;
    private  Integer pId;
    private  Integer avaliable;

    public Integer getPermissId() {
        return permissId;
    }

    public void setPermissId(Integer permissId) {
        this.permissId = permissId;
    }

    public String getPermissName() {
        return permissName;
    }

    public void setPermissName(String permissName) {
        this.permissName = permissName;
    }

    public String getPermissDes() {
        return permissDes;
    }

    public void setPermissDes(String permissDes) {
        this.permissDes = permissDes;
    }

    public Integer getpId() {
        return pId;
    }

    public void setpId(Integer pId) {
        this.pId = pId;
    }

    public Integer getAvaliable() {
        return avaliable;
    }

    public void setAvaliable(Integer avaliable) {
        this.avaliable = avaliable;
    }

    @Override
    public String toString() {
        return "Permission{" +
                "permissId=" + permissId +
                ", permissName='" + permissName + '\'' +
                ", permissDes='" + permissDes + '\'' +
                ", pId=" + pId +
                ", avaliable=" + avaliable +
                '}';
    }
}
