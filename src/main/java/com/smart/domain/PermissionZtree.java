package com.smart.domain;

public class PermissionZtree {
    private Integer Id;
    private  String permissZtreeName;
    private  String name;
    private  Integer pId1;
    private  Integer avaliable2;
    private  Boolean checked;


    public Integer getId() {
        return Id;
    }

    public void setId(Integer id) {
        Id = id;
    }

    public String getPermissZtreeName(String permissName) {
        return permissZtreeName;
    }

    public void setPermissZtreeName(String permissZtreeName) {
        this.permissZtreeName = permissZtreeName;
    }

    public String getPermissZtreeName() {
        return permissZtreeName;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Integer getpId1() {
        return pId1;
    }

    public void setpId1(Integer pId1) {
        this.pId1 = pId1;
    }

    public Integer getAvaliable2() {
        return avaliable2;
    }

    public void setAvaliable2(Integer avaliable2) {
        this.avaliable2 = avaliable2;
    }



    public Boolean getChecked() {
        return checked;
    }

    public void setChecked(Boolean checked) {
        this.checked = checked;
    }
}
